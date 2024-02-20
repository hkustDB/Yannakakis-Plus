## AggReduce Phase: 

# AggReduce33
# 1. aggView
create or replace view aggView835557477225450223 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2396559157063490050 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView835557477225450223 where Person_likes_Message.MessageId=aggView835557477225450223.v1;

# AggReduce34
# 1. aggView
create or replace view aggView8147923932665351587 as select v1, SUM(annot) as annot from aggJoin2396559157063490050 group by v1;
# 2. aggJoin
create or replace view aggJoin5423452915317659525 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8147923932665351587 where Message_hasTag_Tag.MessageId=aggView8147923932665351587.v1;

# AggReduce35
# 1. aggView
create or replace view aggView8671459152171691111 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin7772307380636739199 as select aggJoin5423452915317659525.annot * aggView8671459152171691111.annot as annot from aggJoin5423452915317659525 join aggView8671459152171691111 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin7772307380636739199;

# drop view aggView835557477225450223, aggJoin2396559157063490050, aggView8147923932665351587, aggJoin5423452915317659525, aggView8671459152171691111, aggJoin7772307380636739199;
