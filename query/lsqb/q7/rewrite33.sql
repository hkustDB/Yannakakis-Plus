## AggReduce Phase: 

# AggReduce99
# 1. aggView
create or replace view aggView6859115341162655622 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin7141725341281042373 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6859115341162655622 where Comment_replyOf_Message.ParentMessageId=aggView6859115341162655622.v1;

# AggReduce100
# 1. aggView
create or replace view aggView5774204518226590215 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6849647478391202570 as select v1, aggJoin7141725341281042373.annot * aggView5774204518226590215.annot as annot from aggJoin7141725341281042373 join aggView5774204518226590215 using(v1);

# AggReduce101
# 1. aggView
create or replace view aggView1297155126095572846 as select v1, SUM(annot) as annot from aggJoin6849647478391202570 group by v1;
# 2. aggJoin
create or replace view aggJoin8535247389366776734 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1297155126095572846 where Message_hasCreator_Person.MessageId=aggView1297155126095572846.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8535247389366776734;

# drop view aggView6859115341162655622, aggJoin7141725341281042373, aggView5774204518226590215, aggJoin6849647478391202570, aggView1297155126095572846, aggJoin8535247389366776734;
