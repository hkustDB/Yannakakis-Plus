create or replace view semiUp4370694212295544191 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it where info= 'bottom 10 rank');
create or replace view semiUp3662850825597054801 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiUp8794380983391698534 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select v15 from semiUp4370694212295544191) and production_year>2000;
create or replace view semiUp1578485792687530954 as select v15, v1, v9 from semiUp3662850825597054801 where (v15) in (select v15 from semiUp8794380983391698534);
create or replace view semiDown5833715266885302687 as select id as v1 from company_type AS ct where (id) in (select v1 from semiUp1578485792687530954) and kind= 'production companies';
create or replace view semiDown993568382390630660 as select v15, v16, v19 from semiUp8794380983391698534 where (v15) in (select v15 from semiUp1578485792687530954);
create or replace view semiDown5837480732072001342 as select v15, v3 from semiUp4370694212295544191 where (v15) in (select v15 from semiDown993568382390630660);
create or replace view semiDown8214109914656651518 as select id as v3 from info_type AS it where (id) in (select v3 from semiDown5837480732072001342) and info= 'bottom 10 rank';
create or replace view aggView5983416609940035671 as select v3 from semiDown8214109914656651518;
create or replace view aggJoin4328265190838900778 as select v15 from semiDown5837480732072001342 join aggView5983416609940035671 using(v3);
create or replace view aggView5130061025773374304 as select v15 from aggJoin4328265190838900778 group by v15;
create or replace view aggJoin5122846170349027965 as select v15, v16, v19 from semiDown993568382390630660 join aggView5130061025773374304 using(v15);
create or replace view aggView1247137758974950369 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5122846170349027965 group by v15;
create or replace view aggJoin2808289856043271168 as select v1, v9, v28, v29 from semiUp1578485792687530954 join aggView1247137758974950369 using(v15);
create or replace view aggView1448772441959340565 as select v1 from semiDown5833715266885302687;
create or replace view aggJoin5957090731183192642 as select v9, v28, v29 from aggJoin2808289856043271168 join aggView1448772441959340565 using(v1);
select MIN(v9) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin5957090731183192642;
