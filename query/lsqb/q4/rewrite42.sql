## AggReduce Phase: 

# AggReduce126
# 1. aggView
create or replace view aggView8545084305267721924 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6568306658705378131 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8545084305267721924 where Message_hasTag_Tag.MessageId=aggView8545084305267721924.v1;

# AggReduce127
# 1. aggView
create or replace view aggView5660571544186352457 as select v1, SUM(annot) as annot from aggJoin6568306658705378131 group by v1;
# 2. aggJoin
create or replace view aggJoin1361441476729607882 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5660571544186352457 where Message_hasCreator_Person.MessageId=aggView5660571544186352457.v1;

# AggReduce128
# 1. aggView
create or replace view aggView853328041763415685 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5561476086279251368 as select aggJoin1361441476729607882.annot * aggView853328041763415685.annot as annot from aggJoin1361441476729607882 join aggView853328041763415685 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin5561476086279251368;

# drop view aggView8545084305267721924, aggJoin6568306658705378131, aggView5660571544186352457, aggJoin1361441476729607882, aggView853328041763415685, aggJoin5561476086279251368;
