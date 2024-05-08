create or replace view semiJoinView1149638479467677287 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView4471723283190093682 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8071724431204492919 as select v3, v20 from semiJoinView1149638479467677287 where (v3) in (select (v3) from semiJoinView4471723283190093682);
create or replace view semiJoinView7008784187791939844 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView8071724431204492919);
create or replace view semiJoinView6830177154645785646 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView7008784187791939844);
create or replace view semiJoinView5873761207675175126 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6830177154645785646) and name LIKE 'X%';
create or replace view nAux5 as select v27 from semiJoinView5873761207675175126;
select distinct v27 from nAux5;
