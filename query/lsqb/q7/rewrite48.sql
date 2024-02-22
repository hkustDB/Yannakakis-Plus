create or replace view aggView8136744725928774408 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3229518908939821177 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8136744725928774408 where Message_hasCreator_Person.MessageId=aggView8136744725928774408.v1;
create or replace view aggView7186933868844518955 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6817582008379248548 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7186933868844518955 where Message_hasTag_Tag.MessageId=aggView7186933868844518955.v1;
create or replace view aggView1626310825004564752 as select v1, SUM(annot) as annot from aggJoin6817582008379248548 group by v1;
create or replace view aggJoin2149988337895813899 as select aggJoin3229518908939821177.annot * aggView1626310825004564752.annot as annot from aggJoin3229518908939821177 join aggView1626310825004564752 using(v1);
select SUM(annot) as v9 from aggJoin2149988337895813899;
