## AggReduce Phase: 

# AggReduce102
# 1. aggView
create or replace view aggView3859789557036061130 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin941623258258218202 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3859789557036061130 where Message_hasCreator_Person.MessageId=aggView3859789557036061130.v1;

# AggReduce103
# 1. aggView
create or replace view aggView6624198926313614470 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin7564828754749074750 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6624198926313614470 where Message_hasTag_Tag.MessageId=aggView6624198926313614470.v1;

# AggReduce104
# 1. aggView
create or replace view aggView8532945731114398246 as select v1, SUM(annot) as annot from aggJoin7564828754749074750 group by v1;
# 2. aggJoin
create or replace view aggJoin2847405099128300145 as select aggJoin941623258258218202.annot * aggView8532945731114398246.annot as annot from aggJoin941623258258218202 join aggView8532945731114398246 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2847405099128300145;

# drop view aggView3859789557036061130, aggJoin941623258258218202, aggView6624198926313614470, aggJoin7564828754749074750, aggView8532945731114398246, aggJoin2847405099128300145;
