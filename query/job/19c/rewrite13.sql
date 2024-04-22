create or replace view aggJoin5207660823133530149 as (
with aggView5176013044647952759 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView5176013044647952759 where mi.movie_id=aggView5176013044647952759.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4642712406732306964 as (
with aggView194796036383200834 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView194796036383200834 where ci.role_id=aggView194796036383200834.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5988117664637575227 as (
with aggView3677243099044388915 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin5207660823133530149 join aggView3677243099044388915 using(v30));
create or replace view aggJoin7350416988456850265 as (
with aggView4172395424085272111 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView4172395424085272111 where mc.company_id=aggView4172395424085272111.v23);
create or replace view aggJoin725132353599989998 as (
with aggView6998925534667144141 as (select v53, MIN(v66) as v66 from aggJoin5988117664637575227 group by v53,v66)
select v42, v53, v9, v20, v66 from aggJoin4642712406732306964 join aggView6998925534667144141 using(v53));
create or replace view aggJoin8413837569014318136 as (
with aggView969600087944551155 as (select v53 from aggJoin7350416988456850265 group by v53)
select v42, v9, v20, v66 as v66 from aggJoin725132353599989998 join aggView969600087944551155 using(v53));
create or replace view aggJoin1890904826414826613 as (
with aggView7029677465185796259 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView7029677465185796259 where n.id=aggView7029677465185796259.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin8919269123982991670 as (
with aggView1317995504704749619 as (select v42, MIN(v43) as v65 from aggJoin1890904826414826613 group by v42)
select v9, v20, v66 as v66, v65 from aggJoin8413837569014318136 join aggView1317995504704749619 using(v42));
create or replace view aggJoin8790755764708359845 as (
with aggView7433607416413738131 as (select v9, MIN(v66) as v66, MIN(v65) as v65 from aggJoin8919269123982991670 group by v9,v66,v65)
select v66, v65 from char_name as chn, aggView7433607416413738131 where chn.id=aggView7433607416413738131.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8790755764708359845;
