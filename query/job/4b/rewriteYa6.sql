create or replace view semiUp5108628638476519660 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it where info= 'rating') and info>'9.0';
create or replace view semiUp8005480305283031667 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiUp6475251284717529062 as select v14, v3 from semiUp8005480305283031667 where (v14) in (select id from title AS t where production_year>2010);
create or replace view semiUp7404987046715621183 as select v14, v3 from semiUp6475251284717529062 where (v14) in (select v14 from semiUp5108628638476519660);
create or replace view semiDown3199566700866799633 as select id as v3 from keyword AS k where (id) in (select v3 from semiUp7404987046715621183) and keyword LIKE '%sequel%';
create or replace view semiDown8243289531307339433 as select v14, v1, v9 from semiUp5108628638476519660 where (v14) in (select v14 from semiUp7404987046715621183);
create or replace view semiDown8998506030602813408 as select id as v14, title as v15 from title AS t where (id) in (select v14 from semiUp7404987046715621183) and production_year>2010;
create or replace view semiDown7387749725372195308 as select id as v1 from info_type AS it where (id) in (select v1 from semiDown8243289531307339433) and info= 'rating';
create or replace view aggView2359867974369877336 as select v1 from semiDown7387749725372195308;
create or replace view aggJoin2814367593449751459 as select v14, v9 from semiDown8243289531307339433 join aggView2359867974369877336 using(v1);
create or replace view aggView5377974382232507693 as select v14, v15 as v27 from semiDown8998506030602813408;
create or replace view aggJoin7816190444365705702 as select v14, v3, v27 from semiUp7404987046715621183 join aggView5377974382232507693 using(v14);
create or replace view aggView1211021231867516152 as select v3 from semiDown3199566700866799633;
create or replace view aggJoin750946006516617083 as select v14, v27 from aggJoin7816190444365705702 join aggView1211021231867516152 using(v3);
create or replace view aggView1890970540450839068 as select v14, MIN(v9) as v26 from aggJoin2814367593449751459 group by v14;
create or replace view aggJoin4824202683959338617 as select v27 as v27, v26 from aggJoin750946006516617083 join aggView1890970540450839068 using(v14);
select MIN(v26) as v26, MIN(v27) as v27 from aggJoin4824202683959338617;