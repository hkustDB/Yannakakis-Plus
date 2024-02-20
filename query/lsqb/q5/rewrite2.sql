## AggReduce Phase: 

# AggReduce4
# 1. aggView
create or replace view aggView7093198386303271124 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
# 2. aggJoin
create or replace view aggJoin2197613943942281079 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7093198386303271124 where Comment_replyOf_Message.ParentMessageId=aggView7093198386303271124.v1;

# AggReduce5
# 1. aggView
create or replace view aggView4606853867649917092 as select v3, SUM(annot) as annot, v2 from aggJoin2197613943942281079 group by v3,v2;
# 2. aggJoin
create or replace view aggJoin8851386315344717353 as select annot from Comment_hasTag_Tag as cht, aggView4606853867649917092 where cht.CommentId=aggView4606853867649917092.v3 and v2<TagId;
# Final result: 
select SUM(annot) as v7 from aggJoin8851386315344717353;

# drop view aggView7093198386303271124, aggJoin2197613943942281079, aggView4606853867649917092, aggJoin8851386315344717353;
