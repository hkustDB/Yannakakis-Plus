## AggReduce Phase: 

# AggReduce159
# 1. aggView
create or replace view aggView3168357921605430205 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin250252013907592138 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3168357921605430205 where Person_likes_Message.MessageId=aggView3168357921605430205.v1;

# AggReduce160
# 1. aggView
create or replace view aggView6533215836961283546 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin2506102871474732563 as select v1, aggJoin250252013907592138.annot * aggView6533215836961283546.annot as annot from aggJoin250252013907592138 join aggView6533215836961283546 using(v1);

# AggReduce161
# 1. aggView
create or replace view aggView7539832411295221520 as select v1, SUM(annot) as annot from aggJoin2506102871474732563 group by v1;
# 2. aggJoin
create or replace view aggJoin6835341732623190076 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7539832411295221520 where Comment_replyOf_Message.ParentMessageId=aggView7539832411295221520.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6835341732623190076;

# drop view aggView3168357921605430205, aggJoin250252013907592138, aggView6533215836961283546, aggJoin2506102871474732563, aggView7539832411295221520, aggJoin6835341732623190076;
