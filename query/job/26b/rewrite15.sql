create or replace view aggJoin3995682045424054912 as (
with aggView8401694284788496940 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView8401694284788496940 where ci.person_role_id=aggView8401694284788496940.v9);
create or replace view aggJoin8679430440422897820 as (
with aggView1193524187091097261 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1193524187091097261 where t.kind_id=aggView1193524187091097261.v28 and production_year>2005);
create or replace view aggJoin2394369991014309616 as (
with aggView8586952341483339968 as (select v47, MIN(v48) as v61 from aggJoin8679430440422897820 group by v47)
select movie_id as v47, info_type_id as v23, info as v33, v61 from movie_info_idx as mi_idx, aggView8586952341483339968 where mi_idx.movie_id=aggView8586952341483339968.v47 and info>'8.0');
create or replace view aggJoin3579803557416918272 as (
with aggView2940234571109271850 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView2940234571109271850 where mk.keyword_id=aggView2940234571109271850.v25);
create or replace view aggJoin4098552735249922256 as (
with aggView5166630701156671014 as (select id as v23 from info_type as it2 where info= 'rating')
select v47, v33, v61 from aggJoin2394369991014309616 join aggView5166630701156671014 using(v23));
create or replace view aggJoin4265367588586940468 as (
with aggView4977916602918465272 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin4098552735249922256 group by v47,v61)
select movie_id as v47, subject_id as v5, status_id as v7, v61, v60 from complete_cast as cc, aggView4977916602918465272 where cc.movie_id=aggView4977916602918465272.v47);
create or replace view aggJoin3153695138982767256 as (
with aggView2966086423790419186 as (select v47 from aggJoin3579803557416918272 group by v47)
select v47, v5, v7, v61 as v61, v60 as v60 from aggJoin4265367588586940468 join aggView2966086423790419186 using(v47));
create or replace view aggJoin3758858798666925833 as (
with aggView8972554482790397674 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5, v61, v60 from aggJoin3153695138982767256 join aggView8972554482790397674 using(v7));
create or replace view aggJoin6129958389057868034 as (
with aggView3733779707414404698 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v61, v60 from aggJoin3758858798666925833 join aggView3733779707414404698 using(v5));
create or replace view aggJoin1142547461416285673 as (
with aggView6039611128129256695 as (select v47, MIN(v61) as v61, MIN(v60) as v60 from aggJoin6129958389057868034 group by v47,v61,v60)
select v38, v59 as v59, v61, v60 from aggJoin3995682045424054912 join aggView6039611128129256695 using(v47));
create or replace view aggJoin2335229126598161414 as (
with aggView8434181593041729165 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin1142547461416285673 join aggView8434181593041729165 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin2335229126598161414;
