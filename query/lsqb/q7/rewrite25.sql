## AggReduce Phase: 

# AggReduce75
# 1. aggView
create or replace view aggView547588260695131375 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin3440220599762959426 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView547588260695131375 where Person_likes_Message.MessageId=aggView547588260695131375.v1;

# AggReduce76
# 1. aggView
create or replace view aggView8072033693231104368 as select v1, SUM(annot) as annot from aggJoin3440220599762959426 group by v1;
# 2. aggJoin
create or replace view aggJoin7315307202556817577 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8072033693231104368 where Message_hasTag_Tag.MessageId=aggView8072033693231104368.v1;

# AggReduce77
# 1. aggView
create or replace view aggView7671743968287569385 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8871151592253917572 as select aggJoin7315307202556817577.annot * aggView7671743968287569385.annot as annot from aggJoin7315307202556817577 join aggView7671743968287569385 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8871151592253917572;

# drop view aggView547588260695131375, aggJoin3440220599762959426, aggView8072033693231104368, aggJoin7315307202556817577, aggView7671743968287569385, aggJoin8871151592253917572;
