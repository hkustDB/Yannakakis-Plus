## AggReduce Phase: 

# AggReduce135
# 1. aggView
create or replace view aggView4036392972742301230 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin9063901753330350642 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4036392972742301230 where Person_likes_Message.MessageId=aggView4036392972742301230.v1;

# AggReduce136
# 1. aggView
create or replace view aggView1445637304205082726 as select v1, SUM(annot) as annot from aggJoin9063901753330350642 group by v1;
# 2. aggJoin
create or replace view aggJoin7922897599000570029 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1445637304205082726 where Message_hasCreator_Person.MessageId=aggView1445637304205082726.v1;

# AggReduce137
# 1. aggView
create or replace view aggView7462842873652520553 as select v1, SUM(annot) as annot from aggJoin7922897599000570029 group by v1;
# 2. aggJoin
create or replace view aggJoin485138762215218195 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7462842873652520553 where Comment_replyOf_Message.ParentMessageId=aggView7462842873652520553.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin485138762215218195;

# drop view aggView4036392972742301230, aggJoin9063901753330350642, aggView1445637304205082726, aggJoin7922897599000570029, aggView7462842873652520553, aggJoin485138762215218195;
