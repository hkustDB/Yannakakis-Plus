## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView5316007076338830343 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin7023812239508433160 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5316007076338830343 where Message_hasCreator_Person.MessageId=aggView5316007076338830343.v1;

# AggReduce7
# 1. aggView
create or replace view aggView5037415088173009928 as select v1, SUM(annot) as annot from aggJoin7023812239508433160 group by v1;
# 2. aggJoin
create or replace view aggJoin8764517285250418771 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5037415088173009928 where Person_likes_Message.MessageId=aggView5037415088173009928.v1;

# AggReduce8
# 1. aggView
create or replace view aggView7511309666457109637 as select v1, SUM(annot) as annot from aggJoin8764517285250418771 group by v1;
# 2. aggJoin
create or replace view aggJoin498651805549378510 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7511309666457109637 where Message_hasTag_Tag.MessageId=aggView7511309666457109637.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin498651805549378510;

# drop view aggView5316007076338830343, aggJoin7023812239508433160, aggView5037415088173009928, aggJoin8764517285250418771, aggView7511309666457109637, aggJoin498651805549378510;
