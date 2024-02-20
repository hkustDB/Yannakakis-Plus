## AggReduce Phase: 

# AggReduce162
# 1. aggView
create or replace view aggView3275484823782975183 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6010969933497281588 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3275484823782975183 where Person_likes_Message.MessageId=aggView3275484823782975183.v1;

# AggReduce163
# 1. aggView
create or replace view aggView7968659305047124463 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8956296596355402119 as select v1, aggJoin6010969933497281588.annot * aggView7968659305047124463.annot as annot from aggJoin6010969933497281588 join aggView7968659305047124463 using(v1);

# AggReduce164
# 1. aggView
create or replace view aggView3112779878864661281 as select v1, SUM(annot) as annot from aggJoin8956296596355402119 group by v1;
# 2. aggJoin
create or replace view aggJoin4955776594067915702 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3112779878864661281 where Message_hasTag_Tag.MessageId=aggView3112779878864661281.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4955776594067915702;

# drop view aggView3275484823782975183, aggJoin6010969933497281588, aggView7968659305047124463, aggJoin8956296596355402119, aggView3112779878864661281, aggJoin4955776594067915702;
