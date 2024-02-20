## AggReduce Phase: 

# AggReduce9
# 1. aggView
create or replace view aggView1202191462931221258 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin2455248428804524946 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1202191462931221258 where Comment_replyOf_Message.ParentMessageId=aggView1202191462931221258.v1;

# AggReduce10
# 1. aggView
create or replace view aggView3066010372153482978 as select v1, SUM(annot) as annot from aggJoin2455248428804524946 group by v1;
# 2. aggJoin
create or replace view aggJoin6673763393294961378 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3066010372153482978 where Person_likes_Message.MessageId=aggView3066010372153482978.v1;

# AggReduce11
# 1. aggView
create or replace view aggView199906574292866688 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2084130366434140808 as select aggJoin6673763393294961378.annot * aggView199906574292866688.annot as annot from aggJoin6673763393294961378 join aggView199906574292866688 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2084130366434140808;

# drop view aggView1202191462931221258, aggJoin2455248428804524946, aggView3066010372153482978, aggJoin6673763393294961378, aggView199906574292866688, aggJoin2084130366434140808;
