## AggReduce Phase: 

# AggReduce117
# 1. aggView
create or replace view aggView966299463152618524 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin8178045296438196504 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView966299463152618524 where Message_hasTag_Tag.MessageId=aggView966299463152618524.v1;

# AggReduce118
# 1. aggView
create or replace view aggView7362463888752303154 as select v1, SUM(annot) as annot from aggJoin8178045296438196504 group by v1;
# 2. aggJoin
create or replace view aggJoin5499200530254216342 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7362463888752303154 where Comment_replyOf_Message.ParentMessageId=aggView7362463888752303154.v1;

# AggReduce119
# 1. aggView
create or replace view aggView5495282136504519440 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8413185873161569322 as select aggJoin5499200530254216342.annot * aggView5495282136504519440.annot as annot from aggJoin5499200530254216342 join aggView5495282136504519440 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8413185873161569322;

# drop view aggView966299463152618524, aggJoin8178045296438196504, aggView7362463888752303154, aggJoin5499200530254216342, aggView5495282136504519440, aggJoin8413185873161569322;
