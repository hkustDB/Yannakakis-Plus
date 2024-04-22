create or replace view aggView6089252634527054395 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggView1256455986759447282 as select id as v24, title as v28 from title as t where production_year>1950;
create or replace view aggJoin8255230400094142441 as (
with aggView3480412708803072661 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView3480412708803072661 where mk.keyword_id=aggView3480412708803072661.v22);
create or replace view aggJoin7793509040081720392 as (
with aggView3094105914903425784 as (select v24 from aggJoin8255230400094142441 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView3094105914903425784 where ml.movie_id=aggView3094105914903425784.v24);
create or replace view aggJoin7107103064211790650 as (
with aggView7642687485435074550 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView7642687485435074550 where mc.company_type_id=aggView7642687485435074550.v18);
create or replace view aggJoin2257949708213177739 as (
with aggView1984090107595314585 as (select id as v13 from link_type as lt)
select v24 from aggJoin7793509040081720392 join aggView1984090107595314585 using(v13));
create or replace view aggJoin8311172699835248624 as (
with aggView2593404833471049970 as (select v24 from aggJoin2257949708213177739 group by v24)
select v24, v17, v19 from aggJoin7107103064211790650 join aggView2593404833471049970 using(v24));
create or replace view aggView2687194288223917247 as select v19, v24, v17 from aggJoin8311172699835248624 group by v19,v24,v17;
create or replace view aggJoin7518474144401529933 as (
with aggView3424529705634747950 as (select v17, MIN(v2) as v39 from aggView6089252634527054395 group by v17)
select v19, v24, v39 from aggView2687194288223917247 join aggView3424529705634747950 using(v17));
create or replace view aggJoin550779251093085114 as (
with aggView6667086067954433626 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin7518474144401529933 group by v24,v39)
select v28, v39, v40 from aggView1256455986759447282 join aggView6667086067954433626 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin550779251093085114;
