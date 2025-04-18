create or replace view semiUp6648142715963942330 as select movie_id as v40, company_id as v13, company_type_id as v20 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]') and note LIKE '%(200%)%' and note LIKE '%(worldwide)%';
create or replace view semiUp6112078134611790548 as select movie_id as v40, info_type_id as v22, info as v35 from movie_info AS mi where (movie_id) in (select movie_id from aka_title AS aka_t) and note LIKE '%internet%' and info LIKE 'USA:% 200%';
create or replace view semiUp823450413672421915 as select v40, v13, v20 from semiUp6648142715963942330 where (v20) in (select id from company_type AS ct);
create or replace view semiUp4286302758290451023 as select movie_id as v40, keyword_id as v24 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k);
create or replace view semiUp5566796402317079795 as select v40, v24 from semiUp4286302758290451023 where (v40) in (select v40 from semiUp823450413672421915);
create or replace view semiUp7015591663707248063 as select v40, v22, v35 from semiUp6112078134611790548 where (v22) in (select id from info_type AS it1 where info= 'release dates');
create or replace view semiUp9063410530630006260 as select id as v40, title as v41 from title AS t where (id) in (select v40 from semiUp7015591663707248063) and production_year>2000;
create or replace view semiUp4990425899834677017 as select v40, v24 from semiUp5566796402317079795 where (v40) in (select v40 from semiUp9063410530630006260);
create or replace view semiDown1010289446422292104 as select v40, v13, v20 from semiUp823450413672421915 where (v40) in (select v40 from semiUp4990425899834677017);
create or replace view semiDown1241968557312641778 as select id as v24 from keyword AS k where (id) in (select v24 from semiUp4990425899834677017);
create or replace view semiDown902296738074060025 as select v40, v41 from semiUp9063410530630006260 where (v40) in (select v40 from semiUp4990425899834677017);
create or replace view semiDown421893760671427796 as select id as v20 from company_type AS ct where (id) in (select v20 from semiDown1010289446422292104);
create or replace view semiDown6345033623048638152 as select id as v13 from company_name AS cn where (id) in (select v13 from semiDown1010289446422292104) and country_code= '[us]';
create or replace view semiDown1867829925491532431 as select v40, v22, v35 from semiUp7015591663707248063 where (v40) in (select v40 from semiDown902296738074060025);
create or replace view semiDown6640234867277418993 as select id as v22 from info_type AS it1 where (id) in (select v22 from semiDown1867829925491532431) and info= 'release dates';
create or replace view semiDown205093753377887348 as select movie_id as v40 from aka_title AS aka_t where (movie_id) in (select v40 from semiDown1867829925491532431);
create or replace view aggView444981210220437535 as select v40 from semiDown205093753377887348 group by v40;
create or replace view aggJoin6006397545629501763 as select v40, v22, v35 from semiDown1867829925491532431 join aggView444981210220437535 using(v40);
create or replace view aggView9206404000197741327 as select v22 from semiDown6640234867277418993;
create or replace view aggJoin397523743530862734 as select v40, v35 from aggJoin6006397545629501763 join aggView9206404000197741327 using(v22);
create or replace view aggView3404902393340619414 as select v40, MIN(v35) as v52 from aggJoin397523743530862734 group by v40;
create or replace view aggJoin6771616240250549847 as select v40, v41, v52 from semiDown902296738074060025 join aggView3404902393340619414 using(v40);
create or replace view aggView1500484164587662978 as select v20 from semiDown421893760671427796;
create or replace view aggJoin6016119179809833583 as select v40, v13 from semiDown1010289446422292104 join aggView1500484164587662978 using(v20);
create or replace view aggView771142720559951648 as select v13 from semiDown6345033623048638152;
create or replace view aggJoin8565170281369696021 as select v40 from aggJoin6016119179809833583 join aggView771142720559951648 using(v13);
create or replace view aggView291679926445986676 as select v24 from semiDown1241968557312641778;
create or replace view aggJoin6639623035102660421 as select v40 from semiUp4990425899834677017 join aggView291679926445986676 using(v24);
create or replace view aggView1442934260346564684 as select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin6771616240250549847 group by v40,v52;
create or replace view aggJoin6946802705782034338 as select v40, v52, v53 from aggJoin6639623035102660421 join aggView1442934260346564684 using(v40);
create or replace view aggView5370010242621124650 as select v40 from aggJoin8565170281369696021 group by v40;
create or replace view aggJoin7690521146830662754 as select v52 as v52, v53 as v53 from aggJoin6946802705782034338 join aggView5370010242621124650 using(v40);
select MIN(v52) as v52, MIN(v53) as v53 from aggJoin7690521146830662754;

