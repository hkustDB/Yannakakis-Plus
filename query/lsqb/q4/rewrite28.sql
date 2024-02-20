## AggReduce Phase: 

# AggReduce84
# 1. aggView
create or replace view aggView3026612930383984340 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6633886569396749250 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3026612930383984340 where Message_hasTag_Tag.MessageId=aggView3026612930383984340.v1;

# AggReduce85
# 1. aggView
create or replace view aggView7826974933938650358 as select v1, SUM(annot) as annot from aggJoin6633886569396749250 group by v1;
# 2. aggJoin
create or replace view aggJoin3018307472333913639 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7826974933938650358 where Person_likes_Message.MessageId=aggView7826974933938650358.v1;

# AggReduce86
# 1. aggView
create or replace view aggView3365981157049899250 as select v1, SUM(annot) as annot from aggJoin3018307472333913639 group by v1;
# 2. aggJoin
create or replace view aggJoin1569206612091702636 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3365981157049899250 where Message_hasCreator_Person.MessageId=aggView3365981157049899250.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1569206612091702636;

# drop view aggView3026612930383984340, aggJoin6633886569396749250, aggView7826974933938650358, aggJoin3018307472333913639, aggView3365981157049899250, aggJoin1569206612091702636;
