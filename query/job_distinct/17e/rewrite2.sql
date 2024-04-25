create or replace view semiJoinView5945467817217601190 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView4151066898933249281 as select v3, v20 from semiJoinView5945467817217601190 where (v20) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView8633145082844565240 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (v3) from semiJoinView4151066898933249281);
create or replace view semiJoinView1311782372976683686 as select v3, v25 from semiJoinView8633145082844565240 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3348101121618897411 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1311782372976683686);
create or replace view semiJoinView8560383508118291322 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3348101121618897411);
create or replace view nAux18 as select v27 from semiJoinView8560383508118291322;
select distinct v27 from nAux18;
