create or replace view aggView8338549704054484981 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4529520179759214125 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8338549704054484981 where Message_hasTag_Tag.MessageId=aggView8338549704054484981.v1;
create or replace view aggView2812834241329059964 as select v1, SUM(annot) as annot from aggJoin4529520179759214125 group by v1;
create or replace view aggJoin204124369244910734 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2812834241329059964 where Comment_replyOf_Message.ParentMessageId=aggView2812834241329059964.v1;
create or replace view aggView2127503353638278407 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin766430099448914292 as select aggJoin204124369244910734.annot * aggView2127503353638278407.annot as annot from aggJoin204124369244910734 join aggView2127503353638278407 using(v1);
select SUM(annot) as v9 from aggJoin766430099448914292;
