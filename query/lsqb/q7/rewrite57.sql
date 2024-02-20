## AggReduce Phase: 

# AggReduce171
# 1. aggView
create or replace view aggView784843405787558211 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5029582176324094073 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView784843405787558211 where Message_hasCreator_Person.MessageId=aggView784843405787558211.v1;

# AggReduce172
# 1. aggView
create or replace view aggView13514210895786166 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6247165082529629778 as select v1, aggJoin5029582176324094073.annot * aggView13514210895786166.annot as annot from aggJoin5029582176324094073 join aggView13514210895786166 using(v1);

# AggReduce173
# 1. aggView
create or replace view aggView4707125613010751360 as select v1, SUM(annot) as annot from aggJoin6247165082529629778 group by v1;
# 2. aggJoin
create or replace view aggJoin2789885462840889312 as select annot from Person_likes_Message as Person_likes_Message, aggView4707125613010751360 where Person_likes_Message.MessageId=aggView4707125613010751360.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2789885462840889312;

# drop view aggView784843405787558211, aggJoin5029582176324094073, aggView13514210895786166, aggJoin6247165082529629778, aggView4707125613010751360, aggJoin2789885462840889312;
