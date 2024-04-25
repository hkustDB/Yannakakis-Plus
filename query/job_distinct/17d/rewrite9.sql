create or replace view semiJoinView1766289082375180912 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1856457039501605057 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1766289082375180912);
create or replace view semiJoinView7867377774091590707 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView3846423437662040194 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView7867377774091590707);
create or replace view semiJoinView2706156398496390199 as select v26, v3 from semiJoinView1856457039501605057 where (v3) in (select (v3) from semiJoinView3846423437662040194);
create or replace view semiJoinView5389131433250419803 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView2706156398496390199);
create or replace view nAux84 as select v27 from semiJoinView5389131433250419803;
select distinct v27 from nAux84;
