create or replace view semiJoinView120699060114636925 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6592223168561875476 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView8544707763042597448 as select v3, v20 from semiJoinView6592223168561875476 where (v3) in (select (v3) from semiJoinView120699060114636925);
create or replace view semiJoinView2946620875714059563 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView8544707763042597448);
create or replace view semiJoinView4708211259110445323 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView2946620875714059563);
create or replace view semiJoinView6821615123238684941 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4708211259110445323);
create or replace view nAux5 as select v27 from semiJoinView6821615123238684941;
select distinct v27 from nAux5;
