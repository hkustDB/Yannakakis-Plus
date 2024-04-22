create or replace view aggView4113563644559325404 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView6702313892860486714 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView3809693088028958019 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin4501960467702105759 as (
with aggView5484894567461772499 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView5484894567461772499 where mc.company_id=aggView5484894567461772499.v32);
create or replace view aggJoin8472596333019905627 as (
with aggView7925682970714686161 as (select v18 from aggJoin4501960467702105759 group by v18)
select id as v18, title as v47 from title as t, aggView7925682970714686161 where t.id=aggView7925682970714686161.v18);
create or replace view aggView8478885850683128123 as select v18, v47 from aggJoin8472596333019905627 group by v18,v47;
create or replace view aggJoin5137884569166243844 as (
with aggView3057072007915994751 as (select v9, MIN(v10) as v59 from aggView6702313892860486714 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView3057072007915994751 where ci.person_role_id=aggView3057072007915994751.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4690738631750865454 as (
with aggView9031891510698390657 as (select v18, MIN(v47) as v61 from aggView8478885850683128123 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin5137884569166243844 join aggView9031891510698390657 using(v18));
create or replace view aggJoin2003422635039803890 as (
with aggView1092900481674537175 as (select v35, MIN(v36) as v60 from aggView3809693088028958019 group by v35)
select v35, v20, v22, v59 as v59, v61 as v61, v60 from aggJoin4690738631750865454 join aggView1092900481674537175 using(v35));
create or replace view aggJoin3707287891953234721 as (
with aggView1994959215998874525 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61, v60 from aggJoin2003422635039803890 join aggView1994959215998874525 using(v22));
create or replace view aggJoin3067442362776194181 as (
with aggView7510486289868092068 as (select v35, MIN(v59) as v59, MIN(v61) as v61, MIN(v60) as v60 from aggJoin3707287891953234721 group by v35,v60,v59,v61)
select v3, v59, v61, v60 from aggView4113563644559325404 join aggView7510486289868092068 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3067442362776194181;
