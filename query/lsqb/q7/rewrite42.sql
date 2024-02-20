## AggReduce Phase: 

# AggReduce126
# 1. aggView
create or replace view aggView4428324659728448235 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin1532650849009117217 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4428324659728448235 where Person_likes_Message.MessageId=aggView4428324659728448235.v1;

# AggReduce127
# 1. aggView
create or replace view aggView91802099270767329 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin443881300571211782 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView91802099270767329 where Message_hasCreator_Person.MessageId=aggView91802099270767329.v1;

# AggReduce128
# 1. aggView
create or replace view aggView7349361989820335472 as select v1, SUM(annot) as annot from aggJoin443881300571211782 group by v1;
# 2. aggJoin
create or replace view aggJoin6315314040557755563 as select aggJoin1532650849009117217.annot * aggView7349361989820335472.annot as annot from aggJoin1532650849009117217 join aggView7349361989820335472 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6315314040557755563;

# drop view aggView4428324659728448235, aggJoin1532650849009117217, aggView91802099270767329, aggJoin443881300571211782, aggView7349361989820335472, aggJoin6315314040557755563;
