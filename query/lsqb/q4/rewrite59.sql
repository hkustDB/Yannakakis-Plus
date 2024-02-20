## AggReduce Phase: 

# AggReduce177
# 1. aggView
create or replace view aggView4563809901156389362 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3764572317871456065 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4563809901156389362 where Message_hasTag_Tag.MessageId=aggView4563809901156389362.v1;

# AggReduce178
# 1. aggView
create or replace view aggView529774549045306151 as select v1, SUM(annot) as annot from aggJoin3764572317871456065 group by v1;
# 2. aggJoin
create or replace view aggJoin7512520966068609954 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView529774549045306151 where Comment_replyOf_Message.ParentMessageId=aggView529774549045306151.v1;

# AggReduce179
# 1. aggView
create or replace view aggView1889282847558507873 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin7810580837742664999 as select aggJoin7512520966068609954.annot * aggView1889282847558507873.annot as annot from aggJoin7512520966068609954 join aggView1889282847558507873 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin7810580837742664999;

# drop view aggView4563809901156389362, aggJoin3764572317871456065, aggView529774549045306151, aggJoin7512520966068609954, aggView1889282847558507873, aggJoin7810580837742664999;
