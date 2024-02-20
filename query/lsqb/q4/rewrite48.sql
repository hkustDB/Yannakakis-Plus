## AggReduce Phase: 

# AggReduce144
# 1. aggView
create or replace view aggView2281439355137519705 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5695852981141953361 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2281439355137519705 where Comment_replyOf_Message.ParentMessageId=aggView2281439355137519705.v1;

# AggReduce145
# 1. aggView
create or replace view aggView4941180543532832669 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5783482318835689284 as select v1, aggJoin5695852981141953361.annot * aggView4941180543532832669.annot as annot from aggJoin5695852981141953361 join aggView4941180543532832669 using(v1);

# AggReduce146
# 1. aggView
create or replace view aggView711516253374792776 as select v1, SUM(annot) as annot from aggJoin5783482318835689284 group by v1;
# 2. aggJoin
create or replace view aggJoin6902602694710823328 as select annot from Person_likes_Message as Person_likes_Message, aggView711516253374792776 where Person_likes_Message.MessageId=aggView711516253374792776.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6902602694710823328;

# drop view aggView2281439355137519705, aggJoin5695852981141953361, aggView4941180543532832669, aggJoin5783482318835689284, aggView711516253374792776, aggJoin6902602694710823328;
