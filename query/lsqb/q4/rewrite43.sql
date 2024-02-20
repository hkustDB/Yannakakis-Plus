## AggReduce Phase: 

# AggReduce129
# 1. aggView
create or replace view aggView5261915384371304515 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6504616929730632570 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5261915384371304515 where Message_hasCreator_Person.MessageId=aggView5261915384371304515.v1;

# AggReduce130
# 1. aggView
create or replace view aggView2146947932791186047 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1046821439162381878 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2146947932791186047 where Comment_replyOf_Message.ParentMessageId=aggView2146947932791186047.v1;

# AggReduce131
# 1. aggView
create or replace view aggView776384841360588486 as select v1, SUM(annot) as annot from aggJoin1046821439162381878 group by v1;
# 2. aggJoin
create or replace view aggJoin8670176929025556017 as select aggJoin6504616929730632570.annot * aggView776384841360588486.annot as annot from aggJoin6504616929730632570 join aggView776384841360588486 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8670176929025556017;

# drop view aggView5261915384371304515, aggJoin6504616929730632570, aggView2146947932791186047, aggJoin1046821439162381878, aggView776384841360588486, aggJoin8670176929025556017;
