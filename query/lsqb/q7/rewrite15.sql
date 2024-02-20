## AggReduce Phase: 

# AggReduce45
# 1. aggView
create or replace view aggView6049242687822045050 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin936637757556295494 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6049242687822045050 where Message_hasTag_Tag.MessageId=aggView6049242687822045050.v1;

# AggReduce46
# 1. aggView
create or replace view aggView4548600355999322893 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin1724276477212267253 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4548600355999322893 where Message_hasCreator_Person.MessageId=aggView4548600355999322893.v1;

# AggReduce47
# 1. aggView
create or replace view aggView7974198077961245117 as select v1, SUM(annot) as annot from aggJoin1724276477212267253 group by v1;
# 2. aggJoin
create or replace view aggJoin9221911517390087346 as select aggJoin936637757556295494.annot * aggView7974198077961245117.annot as annot from aggJoin936637757556295494 join aggView7974198077961245117 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin9221911517390087346;

# drop view aggView6049242687822045050, aggJoin936637757556295494, aggView4548600355999322893, aggJoin1724276477212267253, aggView7974198077961245117, aggJoin9221911517390087346;
