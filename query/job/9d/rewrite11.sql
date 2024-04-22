create or replace view aggView675055163425958601 as select id as v18, title as v47 from title as t;
create or replace view aggView2321971630220610053 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView2264525786709178733 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggView3332252514292780282 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin5760852224865454358 as (
with aggView4448932957909322382 as (select v35, MIN(v36) as v60 from aggView2264525786709178733 group by v35)
select v35, v3, v60 from aggView3332252514292780282 join aggView4448932957909322382 using(v35));
create or replace view aggJoin7677015407103362608 as (
with aggView6180421873218388746 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin5760852224865454358 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView6180421873218388746 where ci.person_id=aggView6180421873218388746.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin9048045282799626477 as (
with aggView3479014897021341154 as (select v18, MIN(v47) as v61 from aggView675055163425958601 group by v18)
select v18, v9, v20, v22, v60 as v60, v58 as v58, v61 from aggJoin7677015407103362608 join aggView3479014897021341154 using(v18));
create or replace view aggJoin2942015085536921543 as (
with aggView5797280827467821717 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v60, v58, v61 from aggJoin9048045282799626477 join aggView5797280827467821717 using(v22));
create or replace view aggJoin9020263326113084267 as (
with aggView8492181614419694953 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView8492181614419694953 where mc.company_id=aggView8492181614419694953.v32);
create or replace view aggJoin4945672869802814901 as (
with aggView6354561477646485218 as (select v18 from aggJoin9020263326113084267 group by v18)
select v9, v20, v60 as v60, v58 as v58, v61 as v61 from aggJoin2942015085536921543 join aggView6354561477646485218 using(v18));
create or replace view aggJoin360799914128042599 as (
with aggView4330939375275671696 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin4945672869802814901 group by v9,v60,v58,v61)
select v10, v60, v58, v61 from aggView2321971630220610053 join aggView4330939375275671696 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin360799914128042599;
