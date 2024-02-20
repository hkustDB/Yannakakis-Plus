## AggReduce Phase: 

# AggReduce189
# 1. aggView
create or replace view aggView1573983934216050648 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin317349320238810292 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1573983934216050648 where Person_likes_Message.MessageId=aggView1573983934216050648.v1;

# AggReduce190
# 1. aggView
create or replace view aggView2473496317173296132 as select v1, SUM(annot) as annot from aggJoin317349320238810292 group by v1;
# 2. aggJoin
create or replace view aggJoin1362904534157526383 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2473496317173296132 where Comment_replyOf_Message.ParentMessageId=aggView2473496317173296132.v1;

# AggReduce191
# 1. aggView
create or replace view aggView8506273431390040221 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5856857894355929162 as select aggJoin1362904534157526383.annot * aggView8506273431390040221.annot as annot from aggJoin1362904534157526383 join aggView8506273431390040221 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin5856857894355929162;

# drop view aggView1573983934216050648, aggJoin317349320238810292, aggView2473496317173296132, aggJoin1362904534157526383, aggView8506273431390040221, aggJoin5856857894355929162;
