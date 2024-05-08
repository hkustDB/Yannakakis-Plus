create or replace view semiJoinView4808419152085588954 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6822699303845711702 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3033354247430913026 as select v3, v25 from semiJoinView6822699303845711702 where (v3) in (select (v3) from semiJoinView4808419152085588954);
create or replace view semiJoinView1521567191640966443 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView3033354247430913026);
create or replace view semiJoinView5075220424471328861 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1521567191640966443);
create or replace view semiJoinView8902384759441003856 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView5075220424471328861);
create or replace view nAux11 as select v27 from semiJoinView8902384759441003856;
select distinct v27 from nAux11;
