create or replace view aggView5846567192894060089 as select id as v40, title as v41 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7333603899032221904 as (
with aggView9157924159429970116 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31 from movie_companies as mc, aggView9157924159429970116 where mc.movie_id=aggView9157924159429970116.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin7783494243553496728 as (
with aggView7220341485539332631 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7220341485539332631 where mi.info_type_id=aggView7220341485539332631.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin7216131780453374612 as (
with aggView3973452893640586877 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select v40, v20, v31 from aggJoin7333603899032221904 join aggView3973452893640586877 using(v13));
create or replace view aggJoin3799602090472830133 as (
with aggView4495256223036416015 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin7216131780453374612 join aggView4495256223036416015 using(v20));
create or replace view aggJoin6513114333085177323 as (
with aggView2160615129166128644 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView2160615129166128644 where mk.keyword_id=aggView2160615129166128644.v24);
create or replace view aggJoin9110184805884265755 as (
with aggView3110503019214540220 as (select v40 from aggJoin6513114333085177323 group by v40)
select v40, v31 from aggJoin3799602090472830133 join aggView3110503019214540220 using(v40));
create or replace view aggJoin3437595912560482167 as (
with aggView6871930762545306153 as (select v40 from aggJoin9110184805884265755 group by v40)
select v40, v35, v36 from aggJoin7783494243553496728 join aggView6871930762545306153 using(v40));
create or replace view aggView6853550333174982945 as select v40, v35 from aggJoin3437595912560482167 group by v40,v35;
create or replace view aggJoin4555042031524694682 as (
with aggView2354899663664408957 as (select v40, MIN(v41) as v53 from aggView5846567192894060089 group by v40)
select v35, v53 from aggView6853550333174982945 join aggView2354899663664408957 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin4555042031524694682;
