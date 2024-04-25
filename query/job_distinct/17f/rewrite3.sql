create or replace view semiJoinView7767429441475080147 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView611397168736507489 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3009020544150505199 as select v3, v20 from semiJoinView7767429441475080147 where (v3) in (select (v3) from semiJoinView611397168736507489);
create or replace view semiJoinView5273907178730980708 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView3009020544150505199);
create or replace view semiJoinView263989139408818400 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView5273907178730980708);
create or replace view semiJoinView5005731890834451844 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView263989139408818400) and name LIKE '%B%';
create or replace view nAux39 as select v27 from semiJoinView5005731890834451844;
select distinct v27 from nAux39;
