create or replace view aggView3154446340654199637 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggJoin5023156106645010777 as (
with aggView549165170475287167 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView549165170475287167 where n.id=aggView549165170475287167.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView8623534066394011136 as select v43, v42 from aggJoin5023156106645010777 group by v43,v42;
create or replace view aggJoin7857402685151011522 as (
with aggView4337602723903328789 as (select v42, MIN(v43) as v65 from aggView8623534066394011136 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4337602723903328789 where ci.person_id=aggView4337602723903328789.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1430086568086593419 as (
with aggView7420065912556166999 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin7857402685151011522 join aggView7420065912556166999 using(v51));
create or replace view aggJoin8173144628662033176 as (
with aggView6048184110586628839 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView6048184110586628839 where mc.company_id=aggView6048184110586628839.v23);
create or replace view aggJoin254407993465362146 as (
with aggView1845494652930914200 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView1845494652930914200 where mi.info_type_id=aggView1845494652930914200.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin86384797292252346 as (
with aggView7103647735803446049 as (select v53 from aggJoin254407993465362146 group by v53)
select v53, v9, v20, v65 as v65 from aggJoin1430086568086593419 join aggView7103647735803446049 using(v53));
create or replace view aggJoin2397030134153542382 as (
with aggView3691838537457013405 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin86384797292252346 join aggView3691838537457013405 using(v9));
create or replace view aggJoin2892985033857201982 as (
with aggView4732032398093176298 as (select v53 from aggJoin8173144628662033176 group by v53)
select v53, v20, v65 as v65 from aggJoin2397030134153542382 join aggView4732032398093176298 using(v53));
create or replace view aggJoin2801894958453780461 as (
with aggView6237198247753913126 as (select v53, MIN(v65) as v65 from aggJoin2892985033857201982 group by v53,v65)
select v54, v65 from aggView3154446340654199637 join aggView6237198247753913126 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin2801894958453780461;
