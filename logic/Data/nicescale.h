#ifndef NICESCALE_H
#define NICESCALE_H

class NiceScale
{

public:

    NiceScale() {
        maxTicks = 6;
    }

    /**
    * Instantiates a new instance of the NiceScale class.
    *
    * @param min the minimum data point on the axis
    * @param max the maximum data point on the axis
    */
    NiceScale(double min, double max) {
        minPoint = min;
        maxPoint = max;
        calculate();
    }

    /**
    * Calculate and update values for tick spacing and nice
    * minimum and maximum data points on the axis.
    */
    void calculate() ;

    /**
    * Returns a "nice" number approximately equal to range Rounds
    * the number if round = true Takes the ceiling if round = false.
    *
    * @param range the data range
    * @param round whether to round the result
    * @return a "nice" number to be used for the data range
    */
    double niceNum(double range, bool round);

    /**
    * Sets the minimum and maximum data points for the axis.
    *
    * @param minPoint the minimum data point on the axis
    * @param maxPoint the maximum data point on the axis
    */
    void setMinMaxPoints(double minPoint, double maxPoint);

    /**
    * Sets maximum number of tick marks we're comfortable with
    *
    * @param maxTicks the maximum number of tick marks for the axis
    */
    void setMaxTicks(double maxTicks);
    int decimals(void);

//private:

    double minPoint;
    double maxPoint;
    double maxTicks;
    double tickSpacing;
    double range;
    double niceMin;
    double niceMax;

};

#endif // NICESCALE_H
