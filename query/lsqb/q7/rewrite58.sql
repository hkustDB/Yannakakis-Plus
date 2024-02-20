## AggReduce Phase: 

# AggReduce174
# 1. aggView
create or replace view aggView7202049705415194895 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5403356498022426991 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7202049705415194895 where Person_likes_Message.MessageId=aggView7202049705415194895.v1;

# AggReduce175
# 1. aggView
create or replace view aggView151160363882416438 as select v1, SUM(annot) as annot from aggJoin5403356498022426991 group by v1;
# 2. aggJoin
create or replace view aggJoin6119462752322437363 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView151160363882416438 where Message_hasCreator_Person.MessageId=aggView151160363882416438.v1;

# AggReduce176
# 1. aggView
create or replace view aggView3333960734074220975 as select v1, SUM(annot) as annot from aggJoin6119462752322437363 group by v1;
# 2. aggJoin
create or replace view aggJoin4113506902216012681 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3333960734074220975 where Comment_replyOf_Message.ParentMessageId=aggView3333960734074220975.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4113506902216012681;

# drop view aggView7202049705415194895, aggJoin5403356498022426991, aggView151160363882416438, aggJoin6119462752322437363, aggView3333960734074220975, aggJoin4113506902216012681;
