create or replace view aggJoin2646223312375212624 as (
with aggView5834285406093752214 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView5834285406093752214 where mi.info_type_id=aggView5834285406093752214.v30);
create or replace view aggJoin7097685402626122348 as (
with aggView4090888932417891762 as (select v53 from aggJoin2646223312375212624 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView4090888932417891762 where t.id=aggView4090888932417891762.v53 and production_year>2000);
create or replace view aggView6585544147459170712 as select v53, v54 from aggJoin7097685402626122348 group by v53,v54;
create or replace view aggJoin1162196464532989723 as (
with aggView3446288622243521597 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView3446288622243521597 where n.id=aggView3446288622243521597.v42 and gender= 'f');
create or replace view aggView789543228391569934 as select v42, v43 from aggJoin1162196464532989723 group by v42,v43;
create or replace view aggJoin7758067257067379521 as (
with aggView2489048833070069885 as (select v42, MIN(v43) as v65 from aggView789543228391569934 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView2489048833070069885 where ci.person_id=aggView2489048833070069885.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4692462360860725884 as (
with aggView3666006344582411324 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView3666006344582411324 where mc.company_id=aggView3666006344582411324.v23);
create or replace view aggJoin7346724252838079771 as (
with aggView1850711394882477090 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin7758067257067379521 join aggView1850711394882477090 using(v51));
create or replace view aggJoin2973844131662989152 as (
with aggView3853828299769833565 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin7346724252838079771 join aggView3853828299769833565 using(v9));
create or replace view aggJoin6128017434526228609 as (
with aggView4123558479826364823 as (select v53 from aggJoin4692462360860725884 group by v53)
select v53, v20, v65 as v65 from aggJoin2973844131662989152 join aggView4123558479826364823 using(v53));
create or replace view aggJoin3358357134334048618 as (
with aggView331771289317923614 as (select v53, MIN(v65) as v65 from aggJoin6128017434526228609 group by v53,v65)
select v54, v65 from aggView6585544147459170712 join aggView331771289317923614 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin3358357134334048618;
