create or replace view aggView2237031275094733069 as select title as v38, id as v37 from title as t;
create or replace view aggView1958405491591590308 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin3650573803728998836 as (
with aggView7942161806814229577 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView7942161806814229577 where mi_idx.info_type_id=aggView7942161806814229577.v10);
create or replace view aggJoin5368015364495759903 as (
with aggView1414897691852594309 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView1414897691852594309 where mk.keyword_id=aggView1414897691852594309.v12);
create or replace view aggJoin6367271295410574787 as (
with aggView7712860673723009009 as (select v37 from aggJoin5368015364495759903 group by v37)
select v37, v23 from aggJoin3650573803728998836 join aggView7712860673723009009 using(v37));
create or replace view aggView711012666181317739 as select v23, v37 from aggJoin6367271295410574787 group by v23,v37;
create or replace view aggJoin5033972341044512583 as (
with aggView5730435864678079674 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView5730435864678079674 where mi.info_type_id=aggView5730435864678079674.v8);
create or replace view aggJoin2144747979211295967 as (
with aggView5444891409275702787 as (select v18, v37 from aggJoin5033972341044512583 group by v18,v37)
select v37, v18 from aggView5444891409275702787 where v18= 'Horror');
create or replace view aggJoin4904424829883204596 as (
with aggView2880407617801119722 as (select v37, MIN(v23) as v50 from aggView711012666181317739 group by v37)
select v37, v18, v50 from aggJoin2144747979211295967 join aggView2880407617801119722 using(v37));
create or replace view aggJoin7380840918309147175 as (
with aggView384075172277949562 as (select v37, MIN(v38) as v52 from aggView2237031275094733069 group by v37)
select person_id as v28, movie_id as v37, note as v5, v52 from cast_info as ci, aggView384075172277949562 where ci.movie_id=aggView384075172277949562.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8498225410206256976 as (
with aggView2967424825491449556 as (select v37, MIN(v50) as v50, MIN(v18) as v49 from aggJoin4904424829883204596 group by v37,v50)
select v28, v5, v52 as v52, v50, v49 from aggJoin7380840918309147175 join aggView2967424825491449556 using(v37));
create or replace view aggJoin2946619656365731512 as (
with aggView5234801244205697692 as (select v28, MIN(v52) as v52, MIN(v50) as v50, MIN(v49) as v49 from aggJoin8498225410206256976 group by v28,v49,v50,v52)
select v29, v52, v50, v49 from aggView1958405491591590308 join aggView5234801244205697692 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin2946619656365731512;
