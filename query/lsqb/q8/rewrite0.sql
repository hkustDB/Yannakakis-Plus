create or replace view aggView2476670954915174619 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin7759195531768440581 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2476670954915174619 where Comment_replyOf_Message.CommentId=aggView2476670954915174619.v3;
create or replace view aggView8915878339130859946 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin1907436466293568334 as select MessageId as v1, TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8915878339130859946 where Message_hasTag_Tag.TagId=aggView8915878339130859946.v2;
create or replace view aggView821311781342470479 as select v1, SUM(annot) as annot, v2 from aggJoin1907436466293568334 group by v1,v2;
create or replace view aggJoin6013497139262198746 as select aggJoin7759195531768440581.annot * aggView821311781342470479.annot as annot from aggJoin7759195531768440581 join aggView821311781342470479 using(v1) where v2 < v8;
select SUM(annot) as v9 from aggJoin6013497139262198746;
