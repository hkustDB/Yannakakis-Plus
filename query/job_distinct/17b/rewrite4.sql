create or replace view semiJoinView128434825783100324 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3753463056319057896 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView128434825783100324);
create or replace view semiJoinView1224879251752281759 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView1313057477446883787 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView1224879251752281759);
create or replace view semiJoinView3392800287166190026 as select v26, v3 from semiJoinView3753463056319057896 where (v3) in (select (v3) from semiJoinView1313057477446883787);
create or replace view semiJoinView2595613000968252742 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3392800287166190026);
create or replace view nAux41 as select v27 from semiJoinView2595613000968252742;
select distinct v27 from nAux41;
