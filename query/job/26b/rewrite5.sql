create or replace view aggView240150202064798874 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin1578686769403274736 as (
with aggView1127816944839426195 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1127816944839426195 where t.kind_id=aggView1127816944839426195.v28 and production_year>2005);
create or replace view aggView25656925280423864 as select v47, v48 from aggJoin1578686769403274736 group by v47,v48;
create or replace view aggJoin638568074821424277 as (
with aggView3851171647424653134 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView3851171647424653134 where mi_idx.info_type_id=aggView3851171647424653134.v23);
create or replace view aggJoin4363451027416449295 as (
with aggView8640795392572680555 as (select v47, v33 from aggJoin638568074821424277 group by v47,v33)
select v47, v33 from aggView8640795392572680555 where v33>'8.0');
create or replace view aggJoin9072299312557007599 as (
with aggView8194433278399062145 as (select v9, MIN(v10) as v59 from aggView240150202064798874 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView8194433278399062145 where ci.person_role_id=aggView8194433278399062145.v9);
create or replace view aggJoin5460712628043794269 as (
with aggView6240726952659938379 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView6240726952659938379 where mk.keyword_id=aggView6240726952659938379.v25);
create or replace view aggJoin1043553860130216889 as (
with aggView6375219248640038728 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView6375219248640038728 where cc.status_id=aggView6375219248640038728.v7);
create or replace view aggJoin7458155063977228830 as (
with aggView401618002988793335 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin1043553860130216889 join aggView401618002988793335 using(v5));
create or replace view aggJoin8080570664146927685 as (
with aggView5290367349279816468 as (select v47 from aggJoin7458155063977228830 group by v47)
select v47 from aggJoin5460712628043794269 join aggView5290367349279816468 using(v47));
create or replace view aggJoin6837269781018365134 as (
with aggView1449993137829525426 as (select v47 from aggJoin8080570664146927685 group by v47)
select v38, v47, v59 as v59 from aggJoin9072299312557007599 join aggView1449993137829525426 using(v47));
create or replace view aggJoin3303073902853575165 as (
with aggView2719676279933964464 as (select id as v38 from name as n)
select v47, v59 from aggJoin6837269781018365134 join aggView2719676279933964464 using(v38));
create or replace view aggJoin9025882096854114774 as (
with aggView3002804443339823031 as (select v47, MIN(v59) as v59 from aggJoin3303073902853575165 group by v47,v59)
select v47, v48, v59 from aggView25656925280423864 join aggView3002804443339823031 using(v47));
create or replace view aggJoin6307207665518253297 as (
with aggView2598819900457755195 as (select v47, MIN(v59) as v59, MIN(v48) as v61 from aggJoin9025882096854114774 group by v47,v59)
select v33, v59, v61 from aggJoin4363451027416449295 join aggView2598819900457755195 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin6307207665518253297;
