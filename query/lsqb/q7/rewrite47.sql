## AggReduce Phase: 

# AggReduce141
# 1. aggView
create or replace view aggView1944328808233566306 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6472907355091978312 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1944328808233566306 where Comment_replyOf_Message.ParentMessageId=aggView1944328808233566306.v1;

# AggReduce142
# 1. aggView
create or replace view aggView8574291950224910671 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin7283085148949235845 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8574291950224910671 where Message_hasTag_Tag.MessageId=aggView8574291950224910671.v1;

# AggReduce143
# 1. aggView
create or replace view aggView2360573863005658732 as select v1, SUM(annot) as annot from aggJoin7283085148949235845 group by v1;
# 2. aggJoin
create or replace view aggJoin3921736922888043558 as select aggJoin6472907355091978312.annot * aggView2360573863005658732.annot as annot from aggJoin6472907355091978312 join aggView2360573863005658732 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin3921736922888043558;

# drop view aggView1944328808233566306, aggJoin6472907355091978312, aggView8574291950224910671, aggJoin7283085148949235845, aggView2360573863005658732, aggJoin3921736922888043558;
