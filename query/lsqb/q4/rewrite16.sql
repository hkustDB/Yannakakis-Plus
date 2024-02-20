## AggReduce Phase: 

# AggReduce48
# 1. aggView
create or replace view aggView468678793176063077 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3378134358623727353 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView468678793176063077 where Comment_replyOf_Message.ParentMessageId=aggView468678793176063077.v1;

# AggReduce49
# 1. aggView
create or replace view aggView7758527831039089906 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin941148679318348828 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7758527831039089906 where Message_hasTag_Tag.MessageId=aggView7758527831039089906.v1;

# AggReduce50
# 1. aggView
create or replace view aggView7625481773295125677 as select v1, SUM(annot) as annot from aggJoin941148679318348828 group by v1;
# 2. aggJoin
create or replace view aggJoin1180742548516595125 as select aggJoin3378134358623727353.annot * aggView7625481773295125677.annot as annot from aggJoin3378134358623727353 join aggView7625481773295125677 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin1180742548516595125;

# drop view aggView468678793176063077, aggJoin3378134358623727353, aggView7758527831039089906, aggJoin941148679318348828, aggView7625481773295125677, aggJoin1180742548516595125;
