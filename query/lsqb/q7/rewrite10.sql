## AggReduce Phase: 

# AggReduce30
# 1. aggView
create or replace view aggView8664367621295428516 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin8860754026386311889 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8664367621295428516 where Comment_replyOf_Message.ParentMessageId=aggView8664367621295428516.v1;

# AggReduce31
# 1. aggView
create or replace view aggView4076773107734379147 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin1518813765278034008 as select v1, aggJoin8860754026386311889.annot * aggView4076773107734379147.annot as annot from aggJoin8860754026386311889 join aggView4076773107734379147 using(v1);

# AggReduce32
# 1. aggView
create or replace view aggView4600265175951083550 as select v1, SUM(annot) as annot from aggJoin1518813765278034008 group by v1;
# 2. aggJoin
create or replace view aggJoin7015954363041008491 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4600265175951083550 where Message_hasTag_Tag.MessageId=aggView4600265175951083550.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin7015954363041008491;

# drop view aggView8664367621295428516, aggJoin8860754026386311889, aggView4076773107734379147, aggJoin1518813765278034008, aggView4600265175951083550, aggJoin7015954363041008491;
