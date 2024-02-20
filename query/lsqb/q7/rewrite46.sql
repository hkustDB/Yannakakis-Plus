## AggReduce Phase: 

# AggReduce138
# 1. aggView
create or replace view aggView361342253268030008 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6557361846274288517 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView361342253268030008 where Message_hasTag_Tag.MessageId=aggView361342253268030008.v1;

# AggReduce139
# 1. aggView
create or replace view aggView3834191555419010054 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin6498323159330115352 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3834191555419010054 where Comment_replyOf_Message.ParentMessageId=aggView3834191555419010054.v1;

# AggReduce140
# 1. aggView
create or replace view aggView4883636190135428173 as select v1, SUM(annot) as annot from aggJoin6498323159330115352 group by v1;
# 2. aggJoin
create or replace view aggJoin1981031732962368197 as select aggJoin6557361846274288517.annot * aggView4883636190135428173.annot as annot from aggJoin6557361846274288517 join aggView4883636190135428173 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin1981031732962368197;

# drop view aggView361342253268030008, aggJoin6557361846274288517, aggView3834191555419010054, aggJoin6498323159330115352, aggView4883636190135428173, aggJoin1981031732962368197;
