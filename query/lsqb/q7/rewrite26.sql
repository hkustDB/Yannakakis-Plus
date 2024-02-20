## AggReduce Phase: 

# AggReduce78
# 1. aggView
create or replace view aggView7702467145544782132 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin986548455655615793 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7702467145544782132 where Comment_replyOf_Message.ParentMessageId=aggView7702467145544782132.v1;

# AggReduce79
# 1. aggView
create or replace view aggView2244703136886757341 as select v1, SUM(annot) as annot from aggJoin986548455655615793 group by v1;
# 2. aggJoin
create or replace view aggJoin9056498920327098713 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2244703136886757341 where Message_hasCreator_Person.MessageId=aggView2244703136886757341.v1;

# AggReduce80
# 1. aggView
create or replace view aggView1212160194098341301 as select v1, SUM(annot) as annot from aggJoin9056498920327098713 group by v1;
# 2. aggJoin
create or replace view aggJoin8100783911781890384 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1212160194098341301 where Message_hasTag_Tag.MessageId=aggView1212160194098341301.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8100783911781890384;

# drop view aggView7702467145544782132, aggJoin986548455655615793, aggView2244703136886757341, aggJoin9056498920327098713, aggView1212160194098341301, aggJoin8100783911781890384;
