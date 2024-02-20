## AggReduce Phase: 

# AggReduce99
# 1. aggView
create or replace view aggView7974189858819926147 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin1231213032733850371 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7974189858819926147 where Person_likes_Message.MessageId=aggView7974189858819926147.v1;

# AggReduce100
# 1. aggView
create or replace view aggView8573137673130091547 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2812283300219692948 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8573137673130091547 where Message_hasTag_Tag.MessageId=aggView8573137673130091547.v1;

# AggReduce101
# 1. aggView
create or replace view aggView2354831950429914905 as select v1, SUM(annot) as annot from aggJoin2812283300219692948 group by v1;
# 2. aggJoin
create or replace view aggJoin4367351517533167082 as select aggJoin1231213032733850371.annot * aggView2354831950429914905.annot as annot from aggJoin1231213032733850371 join aggView2354831950429914905 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4367351517533167082;

# drop view aggView7974189858819926147, aggJoin1231213032733850371, aggView8573137673130091547, aggJoin2812283300219692948, aggView2354831950429914905, aggJoin4367351517533167082;
