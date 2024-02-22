create or replace view aggView3544120649840418889 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3582021092971466454 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3544120649840418889 where Comment_replyOf_Message.ParentMessageId=aggView3544120649840418889.v1;
create or replace view aggView2537879791121520520 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6077855765189167155 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2537879791121520520 where Message_hasCreator_Person.MessageId=aggView2537879791121520520.v1;
create or replace view aggView8258119818814946893 as select v1, SUM(annot) as annot from aggJoin6077855765189167155 group by v1;
create or replace view aggJoin4445609689874486690 as select aggJoin3582021092971466454.annot * aggView8258119818814946893.annot as annot from aggJoin3582021092971466454 join aggView8258119818814946893 using(v1);
select SUM(annot) as v9 from aggJoin4445609689874486690;
