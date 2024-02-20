## AggReduce Phase: 

# AggReduce18
# 1. aggView
create or replace view aggView5924971396718811534 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin878252777019297925 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5924971396718811534 where Comment_replyOf_Message.ParentMessageId=aggView5924971396718811534.v1;

# AggReduce19
# 1. aggView
create or replace view aggView1272766962341640497 as select v1, SUM(annot) as annot from aggJoin878252777019297925 group by v1;
# 2. aggJoin
create or replace view aggJoin4701838296729906548 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1272766962341640497 where Message_hasTag_Tag.MessageId=aggView1272766962341640497.v1;

# AggReduce20
# 1. aggView
create or replace view aggView2123928706475040446 as select v1, SUM(annot) as annot from aggJoin4701838296729906548 group by v1;
# 2. aggJoin
create or replace view aggJoin8293522201105903979 as select annot from Person_likes_Message as Person_likes_Message, aggView2123928706475040446 where Person_likes_Message.MessageId=aggView2123928706475040446.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8293522201105903979;

# drop view aggView5924971396718811534, aggJoin878252777019297925, aggView1272766962341640497, aggJoin4701838296729906548, aggView2123928706475040446, aggJoin8293522201105903979;
