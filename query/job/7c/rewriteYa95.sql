create or replace view semiUp3465793477945831870 as select person_id as v24, info_type_id as v16, info as v36 from person_info AS pi where (info_type_id) in (select id from info_type AS it where info= 'mini biography');
create or replace view semiUp5186022165805538686 as select person_id as v24, movie_id as v38 from cast_info AS ci where (movie_id) in (select id from title AS t where production_year<=2010 and production_year>=1980);
create or replace view semiUp6518698501955932758 as select v24, v38 from semiUp5186022165805538686 where (v24) in (select id from name AS n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view semiUp211209715282917817 as select v24, v38 from semiUp6518698501955932758 where (v24) in (select v24 from semiUp3465793477945831870);
create or replace view semiUp1902586570135522940 as select linked_movie_id as v38, link_type_id as v18 from movie_link AS ml where (link_type_id) in (select id from link_type AS lt where link IN ('references','referenced in','features','featured in'));
create or replace view semiUp2796124267878401923 as select v24, v38 from semiUp211209715282917817 where (v38) in (select v38 from semiUp1902586570135522940);
create or replace view semiUp7205049680287519670 as select v24, v38 from semiUp2796124267878401923 where (v24) in (select person_id from aka_name AS an where ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view semiDown2809090161498993911 as select v38, v18 from semiUp1902586570135522940 where (v38) in (select v38 from semiUp7205049680287519670);
create or replace view semiDown1899317163427252465 as select id as v24, name as v25 from name AS n where (id) in (select v24 from semiUp7205049680287519670) and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F';
create or replace view semiDown5339475384301077619 as select person_id as v24 from aka_name AS an where (person_id) in (select v24 from semiUp7205049680287519670) and ((name LIKE '%a%') OR (name LIKE 'A%'));
create or replace view semiDown9025495170096862280 as select id as v38 from title AS t where (id) in (select v38 from semiUp7205049680287519670) and production_year<=2010 and production_year>=1980;
create or replace view semiDown5344552316006919696 as select v24, v16, v36 from semiUp3465793477945831870 where (v24) in (select v24 from semiUp7205049680287519670);
create or replace view semiDown5737305182667674088 as select id as v18 from link_type AS lt where (id) in (select v18 from semiDown2809090161498993911) and link IN ('references','referenced in','features','featured in');
create or replace view semiDown342801876256404458 as select id as v16 from info_type AS it where (id) in (select v16 from semiDown5344552316006919696) and info= 'mini biography';
create or replace view aggView7439147544844871792 as select v16 from semiDown342801876256404458;
create or replace view aggJoin2695733691191245306 as select v24, v36 from semiDown5344552316006919696 join aggView7439147544844871792 using(v16);
create or replace view aggView7165139909134976643 as select v18 from semiDown5737305182667674088;
create or replace view aggJoin2572548929956747940 as select v38 from semiDown2809090161498993911 join aggView7165139909134976643 using(v18);
create or replace view aggView2638642612276161558 as select v38 from aggJoin2572548929956747940 group by v38;
create or replace view aggJoin976179574492536427 as select v24, v38 from semiUp7205049680287519670 join aggView2638642612276161558 using(v38);
create or replace view aggView2452028205751895920 as select v24 from semiDown5339475384301077619 group by v24;
create or replace view aggJoin8227740881316356158 as select v24, v38 from aggJoin976179574492536427 join aggView2452028205751895920 using(v24);
create or replace view aggView1987949211827996072 as select v24, v25 as v50 from semiDown1899317163427252465;
create or replace view aggJoin8288373091980951578 as select v24, v38, v50 from aggJoin8227740881316356158 join aggView1987949211827996072 using(v24);
create or replace view aggView7780169214614514725 as select v24, MIN(v36) as v51 from aggJoin2695733691191245306 group by v24;
create or replace view aggJoin677209000423868293 as select v38, v50 as v50, v51 from aggJoin8288373091980951578 join aggView7780169214614514725 using(v24);
create or replace view aggView367164785843142889 as select v38 from semiDown9025495170096862280;
create or replace view aggJoin6792141731500154211 as select v50, v51 from aggJoin677209000423868293 join aggView367164785843142889 using(v38);
select MIN(v50) as v50, MIN(v51) as v51 from aggJoin6792141731500154211;

