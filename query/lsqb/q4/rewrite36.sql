## AggReduce Phase: 

# AggReduce108
# 1. aggView
create or replace view aggView2501538775079938674 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin7253354391069114423 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2501538775079938674 where Comment_replyOf_Message.ParentMessageId=aggView2501538775079938674.v1;

# AggReduce109
# 1. aggView
create or replace view aggView1109642925847877410 as select v1, SUM(annot) as annot from aggJoin7253354391069114423 group by v1;
# 2. aggJoin
create or replace view aggJoin460991293912993182 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1109642925847877410 where Message_hasCreator_Person.MessageId=aggView1109642925847877410.v1;

# AggReduce110
# 1. aggView
create or replace view aggView6022221649110303066 as select v1, SUM(annot) as annot from aggJoin460991293912993182 group by v1;
# 2. aggJoin
create or replace view aggJoin7372435893381890715 as select annot from Person_likes_Message as Person_likes_Message, aggView6022221649110303066 where Person_likes_Message.MessageId=aggView6022221649110303066.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin7372435893381890715;

# drop view aggView2501538775079938674, aggJoin7253354391069114423, aggView1109642925847877410, aggJoin460991293912993182, aggView6022221649110303066, aggJoin7372435893381890715;
