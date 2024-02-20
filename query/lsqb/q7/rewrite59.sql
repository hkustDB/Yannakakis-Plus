## AggReduce Phase: 

# AggReduce177
# 1. aggView
create or replace view aggView7645450557547810984 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5696091593799853198 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7645450557547810984 where Person_likes_Message.MessageId=aggView7645450557547810984.v1;

# AggReduce178
# 1. aggView
create or replace view aggView8388173265661050928 as select v1, SUM(annot) as annot from aggJoin5696091593799853198 group by v1;
# 2. aggJoin
create or replace view aggJoin7601655587840133259 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8388173265661050928 where Comment_replyOf_Message.ParentMessageId=aggView8388173265661050928.v1;

# AggReduce179
# 1. aggView
create or replace view aggView4630221991364530852 as select v1, SUM(annot) as annot from aggJoin7601655587840133259 group by v1;
# 2. aggJoin
create or replace view aggJoin5168376202594217736 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4630221991364530852 where Message_hasCreator_Person.MessageId=aggView4630221991364530852.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5168376202594217736;

# drop view aggView7645450557547810984, aggJoin5696091593799853198, aggView8388173265661050928, aggJoin7601655587840133259, aggView4630221991364530852, aggJoin5168376202594217736;
