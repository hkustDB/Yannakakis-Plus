create or replace view semiJoinView4818014270387815136 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView6082170457587157709 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3817759370104376782 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView6082170457587157709);
create or replace view semiJoinView8030040293213731436 as select v3, v20 from semiJoinView4818014270387815136 where (v3) in (select (v3) from semiJoinView3817759370104376782);
create or replace view semiJoinView6052887096417161728 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView8030040293213731436);
create or replace view semiJoinView7611691769684060484 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6052887096417161728);
create or replace view nAux44 as select v27 from semiJoinView7611691769684060484;
select distinct v27 from nAux44;
