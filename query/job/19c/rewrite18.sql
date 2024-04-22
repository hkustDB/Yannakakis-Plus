create or replace view aggJoin4883182889360961176 as (
with aggView4802283209679624585 as (select id as v42, name as v65 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4802283209679624585 where ci.person_id=aggView4802283209679624585.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4726534846690675933 as (
with aggView5439514825265890636 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView5439514825265890636 where mi.movie_id=aggView5439514825265890636.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4463273663810846897 as (
with aggView4165855343898038196 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v65 from aggJoin4883182889360961176 join aggView4165855343898038196 using(v51));
create or replace view aggJoin1009965129374520629 as (
with aggView158587666406737930 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin4726534846690675933 join aggView158587666406737930 using(v30));
create or replace view aggJoin8082661206355305838 as (
with aggView3743965099142177098 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v65 as v65 from aggJoin4463273663810846897 join aggView3743965099142177098 using(v42));
create or replace view aggJoin5051856692354837565 as (
with aggView1238903229477419546 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView1238903229477419546 where mc.company_id=aggView1238903229477419546.v23);
create or replace view aggJoin567766430478113545 as (
with aggView12173294851782731 as (select v53, MIN(v66) as v66 from aggJoin1009965129374520629 group by v53,v66)
select v53, v9, v20, v65 as v65, v66 from aggJoin8082661206355305838 join aggView12173294851782731 using(v53));
create or replace view aggJoin8399660853520365531 as (
with aggView6317242469835237975 as (select id as v9 from char_name as chn)
select v53, v20, v65, v66 from aggJoin567766430478113545 join aggView6317242469835237975 using(v9));
create or replace view aggJoin2363899686052290471 as (
with aggView3079731585136004289 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin8399660853520365531 group by v53,v66,v65)
select v65, v66 from aggJoin5051856692354837565 join aggView3079731585136004289 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin2363899686052290471;
